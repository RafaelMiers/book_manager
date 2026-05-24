import unittest
from unittest.mock import Mock

from fastapi import HTTPException

from app.controllers.user_controller import listar_usuarios, obter_usuario_por_id
from app.models.user import Usuario


class TestUserController(unittest.TestCase):
    def test_listar_usuarios_retorna_lista_de_usuarios(self):
        expected = [Mock()]
        session = Mock()
        query = session.query.return_value
        query.all.return_value = expected

        result = listar_usuarios(session)

        self.assertEqual(result, expected)
        session.query.assert_called_once_with(Usuario)

    def test_obter_usuario_por_id_levanta_404_quando_nao_existe(self):
        session = Mock()
        query = session.query.return_value
        query.filter.return_value.first.return_value = None

        with self.assertRaises(HTTPException) as context:
            obter_usuario_por_id(session, usr_id=123)

        self.assertEqual(context.exception.status_code, 404)

import unittest

from app.models.user import Usuario


class TestUsuarioModel(unittest.TestCase):
    def test_usuario_model_tem_as_colunas_necessarias(self):
        columns = Usuario.__table__.c

        self.assertIn("usr_id", columns)
        self.assertIn("usr_nome", columns)
        self.assertIn("usr_email", columns)
        self.assertIn("usr_senha", columns)
        self.assertIn("usr_data_cadastro", columns)

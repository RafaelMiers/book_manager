from fastapi import HTTPException, status
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session

from app.models.user import Usuario

from passlib.context import CryptContext
from app.core.security import criar_token 

pwd_context = CryptContext(schemes=["bcrypt"])


def criar_usuario(db: Session, usr_nome: str, usr_email: str, usr_senha: str) -> Usuario:
    novo_usuario = Usuario(
        usr_nome=usr_nome,
        usr_email=usr_email,
        usr_senha=pwd_context.hash(usr_senha),
    )

    db.add(novo_usuario)
    try:
        db.commit()
        db.refresh(novo_usuario)
    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="E-mail já cadastrado ou dados inválidos.",
        )

    return novo_usuario


def listar_usuarios(db: Session):
    return db.query(Usuario).all()


def obter_usuario_por_id(db: Session, usr_id: int):
    usuario = db.query(Usuario).filter(Usuario.usr_id == usr_id).first()
    if usuario is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Usuário não encontrado.",
        )
    return usuario

def autenticar_usuario(db: Session, usr_email: str, usr_senha: str):
    usuario = db.query(Usuario).filter(Usuario.usr_email == usr_email).first()
    if usuario is None or not pwd_context.verify(usr_senha, usuario.usr_senha):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password.",
        )
    token = criar_token({"sub": str(usuario.usr_id)})
    return {
        "user": usuario,
        "token": {
            "access_token": token,
            "refresh_token": None,
            "expires_at": "2026-12-31T00:00:00Z"  # compute from your JWT expiry
        }
    }
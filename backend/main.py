from fastapi import Depends, FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.controllers.user_controller import (
    criar_usuario as criar_usuario_controller,
    listar_usuarios as listar_usuarios_controller,
    obter_usuario_por_id as obter_usuario_por_id_controller,
)
from app.db.db import Base, engine, get_db

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

class UsuarioCreate(BaseModel):
    usr_nome: str
    usr_email: str
    usr_senha: str

@app.post("/usuarios", status_code=status.HTTP_201_CREATED)
def criar_usuario(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    novo_usuario = criar_usuario_controller(
        db=db,
        usr_nome=usuario.usr_nome,
        usr_email=usuario.usr_email,
        usr_senha=usuario.usr_senha,
    )

    return {
        "usr_id": novo_usuario.usr_id,
        "usr_nome": novo_usuario.usr_nome,
        "usr_email": novo_usuario.usr_email,
        "usr_data_cadastro": novo_usuario.usr_data_cadastro,
    }

@app.get("/usuarios")
def get_usuarios(db: Session = Depends(get_db)):
    usuarios = listar_usuarios_controller(db=db)
    return [
        {
            "usr_id": usuario.usr_id,
            "usr_nome": usuario.usr_nome,
            "usr_email": usuario.usr_email,
            "usr_data_cadastro": usuario.usr_data_cadastro,
        }
        for usuario in usuarios
    ]

@app.get("/usuarios/{usr_id}")
def get_usuario_por_id(usr_id: int, db: Session = Depends(get_db)):
    usuario = obter_usuario_por_id_controller(db=db, usr_id=usr_id)
    return {
        "usr_id": usuario.usr_id,
        "usr_nome": usuario.usr_nome,
        "usr_email": usuario.usr_email,
        "usr_data_cadastro": usuario.usr_data_cadastro,
    }

@app.get("/")
def root():
    return {"message": "Hello from Python!"}
from datetime import datetime, timedelta, timezone

from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.controllers.user_controller import (
    criar_usuario as criar_usuario_controller,
    listar_usuarios as listar_usuarios_controller,
    obter_usuario_por_id as obter_usuario_por_id_controller,
    autenticar_usuario as autenticar_usuario_controller,
)
from app.core.security import criar_token, SECRET_KEY, ALGORITHM
from app.db.db import Base, engine, get_db

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/sign-in")

def _format_user(usuario) -> dict:
    """Maps usr_* fields to the shape Flutter's UserModel.fromJson expects."""
    return {
        "id": str(usuario.usr_id),
        "name": usuario.usr_nome,
        "email": usuario.usr_email,
        "avatar_url": None,
        "created_at": usuario.usr_data_cadastro.isoformat(),
    }

def _format_token(access_token: str) -> dict:
    """Builds the token object Flutter's AuthResponseModel.fromJson expects."""
    expires_at = datetime.now(timezone.utc) + timedelta(days=7)
    return {
        "access_token": access_token,
        "refresh_token": None,
        "expires_at": expires_at.isoformat(),
    }

def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db),
):
    """Dependency that validates the Bearer token and returns the Usuario."""
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Session expired. Please sign in again.",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: str = payload.get("sub")
        if user_id is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    return obter_usuario_por_id_controller(db=db, usr_id=int(user_id))

class SignUpBody(BaseModel):
    name: str
    email: str
    password: str

class SignInBody(BaseModel):
    email: str
    password: str

class RefreshBody(BaseModel):
    refresh_token: str

@app.post("/auth/sign-up", status_code=status.HTTP_201_CREATED)
def sign_up(body: SignUpBody, db: Session = Depends(get_db)):
    usuario = criar_usuario_controller(
        db=db,
        usr_nome=body.name,
        usr_email=body.email,
        usr_senha=body.password,
    )
    token = criar_token({"sub": str(usuario.usr_id)})
    return {
        "user": _format_user(usuario),
        "token": _format_token(token),
    }


@app.post("/auth/sign-in")
def sign_in(body: SignInBody, db: Session = Depends(get_db)):
    usuario = autenticar_usuario_controller(
        db=db,
        usr_email=body.email,
        usr_senha=body.password,
    )
    token = criar_token({"sub": str(usuario.usr_id)})
    return {
        "user": _format_user(usuario),
        "token": _format_token(token),
    }


@app.post("/auth/sign-out", status_code=status.HTTP_200_OK)
def sign_out(_current_user=Depends(get_current_user)):
    return {"detail": "Signed out successfully."}


@app.post("/auth/refresh")
def refresh_token(body: RefreshBody):
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Refresh tokens not yet supported.",
    )
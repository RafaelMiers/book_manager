from sqlalchemy import Column, DateTime, Integer, String, func
from app.db.db import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    usr_id = Column(Integer, primary_key=True, index=True)
    usr_nome = Column(String(length=255), nullable=False)
    usr_email = Column(String(length=255), unique=True, nullable=False)
    usr_senha = Column(String(length=255), nullable=False)
    usr_data_cadastro = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)

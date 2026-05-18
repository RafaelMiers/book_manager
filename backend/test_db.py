import os
from sqlalchemy import create_engine, text

from dotenv import load_dotenv
load_dotenv(dotenv_path='../.env')

DATABASE_URL = os.environ.get("DATABASE_URL")
if not DATABASE_URL:
    print("DATABASE_URL not found in .env")
    exit(1)

try:
    engine = create_engine(DATABASE_URL)
    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1"))
        print("Conexão com o banco de dados bem-sucedida!")
        print(f"Resultado do teste: {result.fetchone()}")
except Exception as e:
    print(f"Erro ao conectar ao banco: {e}")
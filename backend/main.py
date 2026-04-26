from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten this in production
    allow_methods=["*"],
    allow_headers=["*"],
)

class Item(BaseModel):
    name: str

@app.get("/")
def root():
    return {"message": "Hello from Python!"}

@app.post("/items")
def create_item(item: Item):
    return {"created": item.name}
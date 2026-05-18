from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
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

@app.post("/list")
def list_all_items(items: list[Item]):
    return {"items": [item.name for item in items]}
import os
from txtai import Embeddings

embeddings = Embeddings(path="ollama/nomic-embed-text", content=True)
project_root = os.getenv("PROJECT_ROOT")

# 2. Load and index your markdown files
def rebuild_index():
    kb_path = f"{project_root}/knowledge-base"
    documents = []
    for filename in os.listdir(kb_path):
        if filename.endswith(".md"):
            with open(os.path.join(kb_path, filename), 'r') as f:
                documents.append({"id": filename, "text": f.read()})
    embeddings.index(documents)
    embeddings.save("pi_index")

# 3. Simple Search Function
def search(query):
    embeddings.load("pi_index")
    results = embeddings.search(query, 3)
    for res in results:
        print(f"--- Found in: {res['id']} (Score: {res['score']:.2f}) ---")
        print(res['text'][:300] + "...")

# Basic CLI interface
if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        search(sys.argv[1])
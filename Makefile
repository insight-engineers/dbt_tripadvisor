install:
	pip install -r requirements.txt

format:
	pre-commit run --all-files

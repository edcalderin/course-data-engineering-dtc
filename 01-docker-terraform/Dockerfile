FROM python:3.11.7

RUN apt-get update && apt-get install wget

RUN pip install --upgrade pip && pip install poetry

WORKDIR /01-docker-terraform

COPY pyproject.toml poetry.lock ./

RUN poetry install

COPY upload-data.py .

ENTRYPOINT [ "poetry", "run", "python", "upload-data.py"]
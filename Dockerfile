FROM nvcr.io/nvidia/pytorch:22.12-py3

WORKDIR /workspace

RUN pip install -U setuptools
COPY . .
RUN pip install --editable ".[all]"

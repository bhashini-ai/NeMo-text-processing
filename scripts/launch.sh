#!/bin/bash

docker run --gpus=all -it --rm -e CUDA_VISIBLE_DEVICES -v "$(pwd)"/grammars:/grammars nemo-text-processing:latest bash

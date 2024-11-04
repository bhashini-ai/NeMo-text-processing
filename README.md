**NeMo Text Processing**
==========================

Introduction
------------

`nemo-text-processing` is a Python package for text normalization and inverse text normalization.

Documentation
-------------

[NeMo-text-processing (text normalization and inverse text normalization)](https://docs.nvidia.com/deeplearning/nemo/user-guide/docs/en/main/nlp/text_normalization/intro.html).

Tutorials
-----------------

| Google Collab Notebook      | Description |
| ----------- | ----------- |
| [Text_(Inverse)_Normalization.ipynb](https://github.com/NVIDIA/NeMo-text-processing/blob/main/tutorials/Text_(Inverse)_Normalization.ipynb)     | Quick-start guide       |
| [WFST_Tutorial](https://github.com/NVIDIA/NeMo-text-processing/blob/main/tutorials/WFST_Tutorial.ipynb)   | In-depth tutorial on grammar customization        |


Getting help
--------------
If you have a question which is not answered in the [Github discussions](https://github.com/NVIDIA/NeMo-text-processing/discussions), encounter a bug or have a feature request, please create a [Github issue](https://github.com/NVIDIA/NeMo-text-processing/issues). We also welcome you to directly open a [pull request](https://github.com/NVIDIA/NeMo-text-processing/pulls) to fix a bug or add a feature.


Installation
------------

### Conda virtual environment

We recommend setting up a fresh Conda environment to install NeMo-text-processing.

```bash
conda create --name nemo_tn python==3.10
conda activate nemo_tn
```

(Optional) To use [hybrid text normalization](nemo_text_processing/hybrid/README.md) install PyTorch using their [configurator](https://pytorch.org/get-started/locally/). 

```
conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
```
**_NOTE:_** The command used to install PyTorch may depend on your system.


###  Pip

Use this installation mode if you want the latest released version.
```
pip install nemo_text_processing
```

**_NOTE:_** This should work on any Linux OS with x86_64. Pip installation on MacOS and Windows are not supported due to the dependency [Pynini](https://www.openfst.org/twiki/bin/view/GRM/Pynini). On a platform other than Linux x86_64, installing from Pip tries to compile Pynini from scratch, and requires OpenFst headers and libraries to be in the expected place. So if it's working for you, it's because you happen to have installed OpenFst in the right way in the right place. So if you want to Pip install Pynini on MacOS, you have to have pre-compiled and pre-installed OpenFst. The Pynini README for that version should tell you which version it needs and what `--enable-foo` flags to use.
Instead, we recommend you to use conda-forge to install Pynini on MacOS or Windows:
`conda install -c conda-forge pynini=2.1.6.post1`.


###  Pip from source

Use this installation mode if you want the a version from particular GitHub branch (e.g main).

```
pip install Cython
python -m pip install git+https://github.com/NVIDIA/NeMo-text-processing.git@{BRANCH}#egg=nemo_text_processing
```


### From source

Use this installation mode if you are contributing to NeMo-text-processing.

```
git clone https://github.com/NVIDIA/NeMo-text-processing
cd NeMo-text-processing
./reinstall.sh
```

**_NOTE:_** If you only want the toolkit without additional conda-based dependencies, you may replace ``reinstall.sh`` with ``pip install -e .`` with the NeMo-text-processing root directory as your current working director.


Contributing
------------
We welcome community contributions! Please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.



Citation
--------

```
@inproceedings{zhang21ja_interspeech,
  author={Yang Zhang and Evelina Bakhturina and Boris Ginsburg},
  title={{NeMo (Inverse) Text Normalization: From Development to Production}},
  year=2021,
  booktitle={Proc. Interspeech 2021},
  pages={4857--4859}
}

@inproceedings{bakhturina22_interspeech,
  author={Evelina Bakhturina and Yang Zhang and Boris Ginsburg},
  title={{Shallow Fusion of Weighted Finite-State Transducer and Language Model for
Text Normalization}},
  year=2022,
  booktitle={Proc. Interspeech 2022}
}
```

License
-------
NeMo-text-processing is under [Apache 2.0 license](LICENSE).


Shiva's References
------------------

Text Normalization
```
import nemo_text_processing
import os

# create text normalization instance that works on cased input
from nemo_text_processing.text_normalization.normalize import Normalizer
normalizer = Normalizer(input_case='cased', lang='en', cache_dir='/grammars')

# run normalization on example string input
written = "We paid $123 for this desk."
normalized = normalizer.normalize(written, verbose=True, punct_post_process=True)
print(normalized)

# Long input text could be split into sentences as follows:
written = "Mr. Smith paid $111 in U.S.A. on Dec. 17th. We paid $123 for this desk."
# split long text into sentences
sentences = normalizer.split_text_into_sentences(written)
for sent in sentences:
    print(sent)

# normalize each sentence separately using normalize() or all sentences at once with normalize_list()
normalizer.normalize_list(sentences)
```

Export Text Normalization Grammars
```
python tools/text_processing_deployment/pynini_export.py --output_dir=/grammars/exported --language=en --grammars=tn_grammars --input_case=cased --cache_dir /grammars
```

Inverse Text Normalization
```
import nemo_text_processing
import os

# create inverse text normalization instance
from nemo_text_processing.inverse_text_normalization.inverse_normalize import InverseNormalizer
inverse_normalizer = InverseNormalizer(input_case='cased', lang='en', cache_dir='/grammars')

# run ITN on example string input
spoken = "we paid one hundred twenty three dollars for this desk"
un_normalized = inverse_normalizer.inverse_normalize(spoken, verbose=True)
print(un_normalized)
```

Export Inverse Text Normalization Grammars
```
python tools/text_processing_deployment/pynini_export.py --output_dir=/grammars/exported --language=en --grammars=itn_grammars --input_case=cased --cache_dir /grammars
```
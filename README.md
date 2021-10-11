**Access to Fastapi Documentation**: Since this is a microservice based design, every NLP task has its own seperate documentation
- News Classification: http://localhost:8080/api/v1/classification/docs

- Sentiment Analysis: http://localhost:8080/api/v1/sentiment/docs

- NER: http://localhost:8080/api/v1/ner/docs

- Summarization: http://localhost:8080/api/v1/summary/docs


### Directory Details

* **Front End**: Front end code is in the `src_streamlit` folder. Along with the `Dockerfile` and `requirements.txt`

* **Back End**: Back End code is in the `src_fastapi` folder.
    * This folder contains directory for each task: `Classification`, `ner`, `summary`...etc
    * Each NLP task has been implemented as a microservice, with its own fastapi server and requirements and Dockerfile so that they can be independently mantained and managed.
    * Each NLP task has its own folder and within each folder each trained model has 1 folder each. For example:
    ```
    - sentiment
        > app
            > api
                > distilbert
                    - model.bin
                    - network.py
                    - tokeniser files
                >roberta
                    - model.bin
                    - network.py
                    - tokeniser files
    ```
    * For each new model under each service a new folder will have to be added.
    * Each folder model will need the following files:
        * Model bin file.
        * Tokenizer files
        * `network.py` Defining the class of the model if customised model used.

    * `config.json`: This file contains the details of the models in the backend and the dataset they are trained on.

<a id='section03c'></a>

### How to Add a new Model

1. Fine Tune a transformer model for specific task. You can leverage the [transformers-tutorials](https://github.com/abhimishra91/transformers-tutorials)

2. Save the model files, tokenizer files and also create a `network.py` script if using a customized training network.

3. Create a directory within the NLP task with `directory_name` as the `model name` and save all the files in this directory.

4. Update the `config.json` with the model details and dataset details.

5. Update the `<service>pro.py` with the correct imports and conditions where the model is imported. For example for a new Bert model in Classification Task, do the following:
    * Create a new directory in `classification/app/api/`. Directory name `bert`.
    * Update `config.json` with following:
        ```json
        "classification": {
        "model-1": {
            "name": "DistilBERT",
            "info": "This model is trained on News Aggregator Dataset from UC Irvin Machine Learning Repository. The news headlines are classified into 4 categories: **Business**, **Science and Technology**, **Entertainment**, **Health**. [New Dataset](https://archive.ics.uci.edu/ml/datasets/News+Aggregator)"
        },
        "model-2": {
            "name": "BERT",
            "info": "Model Info"
        }
        }
        ```
    * Update `classificationpro.py` with the following snippets:
        
        **_Only if customized class used_**
        ```python
        from classification.bert import BertClass
        ```

        **_Section where the model is selected_**
        ```python
        if model == "bert":
            self.model = BertClass()
            self.tokenizer = BertTokenizerFast.from_pretrained(self.path)
        ```

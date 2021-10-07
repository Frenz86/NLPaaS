FROM tiangolo/uvicorn-gunicorn:python3.7

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt \
    && rm -rf /root/.cache/pip

COPY . /app/

EXPOSE 8501 8080 80 443 22

# cmd to launch app when container is run
CMD streamlit run app.py


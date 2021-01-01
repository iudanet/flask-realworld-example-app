FROM python:3.8

ENV CONDUIT_SECRET='something-really-secret' \
    FLASK_APP=/app/autoapp.py \
    FLASK_DEBUG=1
WORKDIR /app

COPY requirements requirements
COPY requirements.txt requirements.txt


RUN pip install -r requirements.txt
COPY . .
RUN flask db init && \
flask db migrate && \
flask db upgrade 

CMD [ "gunicorn", "autoapp:app", "-b", "0.0.0.0:5000", "-w", "3" ]
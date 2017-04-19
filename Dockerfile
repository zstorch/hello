FROM python:alpine

RUN pip install -U setuptools
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD app /app
WORKDIR /app
RUN ./manage.py makemigrations && \
    ./manage.py migrate && \
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('zz','','12')" | ./manage.py shell


CMD ["./manage.py", "runserver", "0.0.0.0:8000" ]

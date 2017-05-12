FROM danielwhatmuff/zappa

ARG version

WORKDIR /var/task

ENV PYTHONPATH /var/task:/var/task/source

RUN pip install -U zappa==${version}

# Add your extra requirements here e.g. postgres-devel 
# RUN yum install -y yourpackages

CMD ["zappa"]

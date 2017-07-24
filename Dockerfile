FROM postgres:9.5.6
RUN apt-get update
RUN apt-get install -y postgresql-server-dev-9.5 build-essential
WORKDIR /jieba
ADD . /jieba
ENV USE_PGXS 1
RUN make && make install
RUN tar -Pvzf /jieba.tar.gz -c /usr/lib/postgresql/9.5/lib/pg_jieba.so \
/usr/share/postgresql/9.5/extension/pg_jieba--1.0.sql \
/usr/share/postgresql/9.5/extension/pg_jieba.control \
/usr/share/postgresql/9.5/extension/pg_jieba--unpackaged--1.0.sql \
/usr/share/postgresql/9.5/tsearch_data/jieba.dict.utf8 \
/usr/share/postgresql/9.5/tsearch_data/jieba.hmm_model.utf8 \
/usr/share/postgresql/9.5/tsearch_data/jieba.user.dict.utf8 \
/usr/share/postgresql/9.5/tsearch_data/jieba.stop

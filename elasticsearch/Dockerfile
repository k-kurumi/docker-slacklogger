FROM elasticsearch:1.6

# install head
RUN /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head

# install kuromoji
RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/elasticsearch-analysis-kuromoji/2.5.0

# install HQ
RUN /usr/share/elasticsearch/bin/plugin --install royrusso/elasticsearch-HQ

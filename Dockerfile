# Based on Ubuntu 14.04
FROM ubuntu:trusty

# Install Packages, via apt-get. 
RUN apt-get update && apt-get install -y \
	build-essential \
	pandoc \
	wkhtmltopdf \
	xvfb \
	ttf-wqy-zenhei \
	git \
	rubygems-integration \
	ruby-dev \
	libimage-exiftool-perl \
	python-twisted

# Now Change wkhtmltopdf
RUN echo 'xvfb-run --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf $*' > /usr/bin/wkhtmltopdf.sh
RUN chmod a+x /usr/bin/wkhtmltopdf
RUN chmod a+x /usr/bin/wkhtmltopdf.sh 
RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf

# Now Run gems 
RUN gem install compass
RUN gem install susy

# Git Clone the CV FrameWork from github.
RUN mkdir -p /opt/Code/
RUN git clone https://github.com/barraq/pandoc-moderncv.git  /opt/Code/pandoc-moderncv

# Now begin to build the cv, using the demo 'scaffold'
RUN cd /opt/Code/pandoc-moderncv/ && make scaffold && make pdf HTMLTOPDF=wkhtmltopdf

# Run http server on server 5177, since in dist/ folder we will have the html and pdf
EXPOSE 5177
CMD ["twistd", "-n", "web", "-p", "5177", "--path", "/opt/Code/pandoc-moderncv/dist/"]

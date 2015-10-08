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
	libimage-exiftool-perl 

# Now Change wkhtmltopdf
RUN echo 'xvfb-run --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf $*' > /usr/bin/wkhtmltopdf.sh
RUN chmod a+x /usr/bin/wkhtmltopdf
RUN chmod a+x /usr/bin/wkhtmltopdf.sh 
RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf

# Now Run gems 
RUN gem install compass
RUN gem install susy

# Git Clone the CV FrameWork from github.
RUN mkdir -p /root/Code/
RUN git clone https://github.com/barraq/pandoc-moderncv.git  /root/Code/pandoc-moderncv
RUN mkdir -p /root/Code/pandoc-moderncv/cv/images

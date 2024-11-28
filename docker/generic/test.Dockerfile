FROM amazonlinux:2
RUN yum install -y rpmbuild rpmdevtools make openssl openssh --skip-broken

COPY --from=dph5199278/openssl:3.3 /usr/local/openssl/bin/openssl /usr/bin/
COPY --from=dph5199278/openssl:3.3 /usr/local/openssl/ssl/openssl.cnf /usr/local/openssl/ssl/openssl.cnf 

COPY src /build/src
COPY bin /build/bin 
COPY rpmsrc /build/rpmsrc
COPY VERSION /build/VERSION
COPY Makefile /build/Makefile
COPY unit-test /build/unit-test

RUN sed -i 's=/usr/bin/==g; 1 ! s=/bin/==g' build/src/bin/* \
	&& build/bin/unit_test_suite.sh

WORKDIR /build
CMD ["bin/unit_test_suite.sh"]

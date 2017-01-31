FROM centos 

LABEL io.k8s.description="Test node for Ansible playbook to image builder" \
      io.k8s.display-name="playbook2image" \
      io.openshift.expose-services="22:ssh" \
      io.openshift.tags="test"

ENV APP_ROOT=/opt/app-root \
    USER_NAME=default \
    USER_UID=10001
ENV APP_HOME=${APP_ROOT}/src  PATH=$PATH:${APP_ROOT}/bin
COPY user_setup /tmp/
COPY bin/ ${APP_ROOT}/bin/

RUN yum install -y  --setopt=tsflags=nodocs openssh-server openssh-clients && \
    yum clean all -y && \
    echo "Port 22222" >> /etc/ssh/sshd_config && \
    #ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    mkdir -p ${APP_HOME} ${APP_ROOT}/etc && \
    chmod -R ug+x ${APP_ROOT}/bin ${APP_ROOT}/etc /tmp/user_setup && \
    /tmp/user_setup


EXPOSE 22222
### Containers should NOT run as root as a good practice
USER ${USER_UID}
WORKDIR ${APP_ROOT}
### arbitrary uid recognition at runtime - for OpenShift deployments
RUN sed "s@${USER_NAME}:x:${USER_UID}:0@${USER_NAME}:x:\${USER_ID}:\${GROUP_ID}@g" /etc/passwd > ${APP_ROOT}/etc/passwd.template
ENTRYPOINT [ "uid_entrypoint" ]
CMD ["/usr/sbin/sshd", "-D"]

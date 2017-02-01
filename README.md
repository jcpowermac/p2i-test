## playbook2image testing

This project provides:
- Testing for [playbook2image](https://github.com/aweiteka/playbook2image) project without external dependencies.
- An example OCP template that could be modified to support additional use cases.

```
curl -O https://raw.githubusercontent.com/jcpowermac/playbook2image-example/master/template.yaml
mkdir -p /tmp/p2ikeys
ssh-keygen -t rsa -f /tmp/p2ikeys/id_rsa -N ''
oc new-project at
oc secrets new sshkeys /tmp/p2ikeys/id_rsa /tmp/p2ikeys/id_rsa.pub authorized_keys=/tmp/p2ikeys/id_rsa.pub
```

The job is unable to locate the image to use, modify the `image` variable for your environment.

```
oc process -f template.yaml | oc create -f -
```

[![asciicast](https://asciinema.org/a/101033.png)](https://asciinema.org/a/101033)



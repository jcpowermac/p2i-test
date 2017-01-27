## playbook2image example

Using [playbook2image](https://github.com/aweiteka/playbook2image) project as a guide this is an example of how to use within OpenShift.

Commands to test this project.  The `INVENTORY_URL` listed in the jobv1.yaml needs to be modified to your inventory.

```
oc new-project playbook2image-example
oc secrets new-sshauth sshkey --ssh-privatekey ~/.ssh/id_rsa
oc new-build docker.io/aweiteka/playbook2image~https://github.com/jcpowermac/playbook2image-example
oc logs -f bc/playbook2image-example
oc create -f jobv1.yaml
oc get job
oc get pod
oc logs -f playbook2image-example-swd8f
oc get jobs
```

[![asciicast](https://asciinema.org/a/101033.png)](https://asciinema.org/a/101033)



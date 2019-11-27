# docker-swarm-tls-ansible

[![action status](https://github.com/Naramsim/docker-swarm-tls-ansible/workflows/Ansible%20Lint/badge.svg)](https://github.com/Naramsim/docker-swarm-tls-ansible/actions)

This project is just a coding challange I was asked to do. Starting from two CentOS machines with and attached volume you should deploy Docker, a Swarm, open the Docker APIs securely.

The IPs of the machines are hard-coded in the `ansible/hosts.yml` file.

## Init

To init the two machines you should upload your public key to them and then run

```sh
ansible-playbook -e 'ansible_user=<initial_user_on_the_machine>' -i hosts.yml init.yml
```

This will create the user `ansible` on the machine which will be then used by ansible.

## Run

Before running ansible you should make a copy of the `docker-tls.password.sample` and change the password written in there.

```sh
cp docker-tls.password.sample docker-tls.password
nano docker-tls.password
```

After that you can run ansible

```sh
ansible-playbook -i hosts.yml playbook.yml
```

You should be now able to comminicate to the single swarm manager using the certificates that had beed downloaded to your machine in the `client-certificates` folder

```sh
docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem -H='35.204.137.154:2375' node ls
```

You should obviously change the above IP with your manager's one.

## Improvements

Right now you can only have a single manager. To do things properly you should divide the manager role in two, one that is execute only once and creates the swarm and register all the tokens (worker+manager) and then run a second manager role attaching additional managers to the first one.

Right now the Docker APIs are exposed with TLS only by a single machine. You could enable it for all the machines by gathering first their IPs, creating a certificate that is valid for all those IPs and then share the generated files among the machines.

## Notes

The two machines were created with GCP and a volume of 10GB was attached to them. The machines are pretty small (`f1`) so the Swarm is only able to host few Nginxs.

If you don't have Ansible on your machine you can use the scripts in the `scripts` folder to generate a container able to run it. Especially if you are on Windows.

```sh
sh init_ansible.sh [<name_of_key_to_use_in_~/.ssh>]
sh start_ansible.sh
```

## Credits

https://github.com/ruanbekker/ansible-docker-swarm
https://github.com/ansible/role-secure-docker-daemon
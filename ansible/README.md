# Ansible deployment

## Init

```sh
ansible-playbook -e 'ansible_user=<initial_user_on_the_machine>' -i hosts.yml init.yml
```

## Run

```sh
ansible-playbook -i hosts.yml playbook.yml
```

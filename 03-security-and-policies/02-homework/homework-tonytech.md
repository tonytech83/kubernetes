# Tasks *
You are expected to complete the following set of tasks:
### 1.	Create and register two Kubernetes uses – **Ivan** (**ivan**) and **Mariana** (**mariana**) who are part of the **Gurus** (**gurus**) group
- Setting up a Vanilla Kubernetes cluster
- Create users with `create_k8s_user.sh` bash script
```sh

```
### 2.	Create a **namespace** named **projectx**
### 3.	Create a **LimitRange** for the namespace to set **defaults**, **minimum** and **maximum** both for **CPU** and **memory** (use values that you consider suitable)
### 4.	Create a **ResourceQuota** for the namespace to set **requests** and **limits** both for **CPU** and **memory** (use values that you consider suitable). In addition, add limits for **pods**, **services**, **deployments**, and **replicasets** (again, use values that you find appropriate)
### 5.	Create a custom role (**devguru**) which will allow the one that has it to do anything with any of the following resources **pods**, **services**, **deployments**, and **replicasets**. Grant the role to **ivan** and **mariana** (or to the group they belong to) for the namespace created earlier
### 6.	Using one of the two users, deploy the **producer-consumer** application (use the attached files – you may need to modify them a bit). Deploy one additional pod that will act as a (curl) **client**
### 7.	Create one or more **NetworkPolicy** resources in order to
a.	Allow communication to the **producer** only from the **consumer**
b.	Allow communication to the **consumer** only from the **client**

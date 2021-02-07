# CHANGELOG

<!--- next entry here -->

## 0.0.17
2021-02-07

### Fixes

- version tags (b130890172360ba08aaa193e264bd2450283cd66)

## 0.0.16
2021-02-07

### Fixes

- build and option to specify version manually using --build-arg TORVERSION=$TAG (2c538a4da432c2afb63edcb93925a23761bd7d05)

## 0.0.15
2021-02-06

### Fixes

- added k8s class yamls (ca9b1767efc4a1ae27b8b194a40353914fda91b4)

## 0.0.14
2021-02-06

### Fixes

- added chart (6b52740b205b2968ee7e1d9b46a38b9101e16754)

## 0.0.13
2021-02-04

### Fixes

- Updating tor version tor-0.4.4.7 (d5e5f00073caec5c0aa5ebc4d3851c8d276f897e)

## 0.0.12
2020-11-13

### Fixes

- Updating tor version tor-0.4.4.6 (a22b1092e0865f006dcb5dae00e4c697ecbfab96)

## 0.0.11
2020-10-04

### Fixes

- order of stages (3095cfab6d979a12d977b18696a7f94459313397)

## 0.0.10
2020-10-04

### Fixes

- autocommit new tor version (37d44c3c22d595c1ae30e0cb56036421e9b68e9a)
-  (8b80b9ec254ab83b507cb2a5e888ec3cd0dfa483)
- initial commit .tor-version (06b4b436f558c5eba196011156949a2f3c5b6847)
-  (7a34a9ae5402061562c451ad3224b81d1fed30f8)
-  (75bdfb93c7494463edb7f62dbbaa9c9bb1601f28)
- autoupdate (90020d80c526e7fc82e92c1ad823f4103c8b56d7)
-  (d1a80257bf3b85ab0eddfafaede82a3fcea7c1d5)
-  (a7e1f7089c6a76f25e44f7ae55fc56494bb5b390)
-  (88c65b074149220f494e16b550b0f26fe0a7fb17)
-  (0d8fea0eb0bb5446940e62af2fb6712f13e2eac8)
-  (c955e9acba7074f06990c4c4f036c8a04063eee4)
- Updating tor to tor-0.4.4.5 (cbe70c7f51f6c3f8dbe965fa2e181c4d2d5a1eaf)

## 0.0.9
2020-10-04

### Fixes

-  (659b44204f6aa8ae5f9bc83a516f18358e670e7c)

## 0.0.8
2020-10-04

### Fixes

- intendation (4ae44a8dddaae971fc177067c50c5f8727aeacf2)

## 0.0.7
2020-10-04

### Fixes

- mirroring to github (0b7f0e9b1c7fc2e7bf37d03f54570cde4fc7d9d9)

## 0.0.6
2020-10-04

### Fixes

- mirror image to ghcr.io (2ce6fd372f75ff80434faf569365ccbd699f0064)

## 0.0.5
2020-09-12

### Fixes

- version (af79f540a06156fdecd943f89fd58e40a0b9fc97)
- version (3f182fdc8a4a18208e65f5a1ae9d1ec0304ec62c)

## 0.0.4
2020-09-12

### Fixes

- tag naming (a76f0c8aead6da2ecac9851ae6d5bd89db83a4ba)

## 0.0.3
2020-09-12

### Fixes

- release version (7ed99cf616c25f1534e3aed89deb7e959ed0c716)

## 0.0.2
2020-09-12

### Fixes

- fixed README.md, removed charts and class deployment.yaml due to being in own repository (eb18b9f129c950cbb1c051624590022a3dfc67bf)
- adding tor version to tag (7993424442aa88656780715fe804731e91aebf56)
- file naming gitlab-ci.yml (f1eeb803aede74cc7594c1de23ec356ac820044f)
- tor version (6664f2f9b7dc757a0d169dfca7e9eca5f33a6f6b)
- tor version (705b529fdeb1af86eab052a9f801a71def17a729)
- tor version (c242a56df32550fbf0bdb1a4afd72519f8403c57)
- tor release version as meta in tag (d0898344f23ad26f2fa187babe70f25513c1abda)
- docker tag (c751dae0777246838c37842c9cfa4360278129c2)
- dockerhub tag naming (028930fa57148601adf8fd349372a27251734265)
- docker tag naming (8bf7a0a2c3c625835a498d535305b12b8980a4f5)

## 0.0.1
2020-09-02

### Fixes

- README.md (fbeedb3047047aa0059def66c2a5c0fb336f5d4c)
- tor is build from src (a2307ee75d250720956fced7b8903fa7079e594c)
- naming (2c655a027f112d906b8ddf35a436489e374e1fdc)
- fixed README.md (e81e91fff2dfab97cfeb5149858a8e2dfa2df700)
- README.md (beb233d52a036a179914d35c62e42a3477c94691)
- Added alpine-tor-deployment.yaml for kubernetes deployment (cb0fe39643104f926b584c14fb77bbdca0baae31)
- Added entrypoint.sh which sets required values in torrc dependent on the environment variable "mode". Added related deployment yamls for each mode (2aaf35e16fd590a6e1d633f0e5573deb633658e4)
- updated README.md (6c44a200a4f139bda02dea3de21dfead8b19d650)
- fixed deployment env variables (5c3b2b56938cfa923077f3a27a1cb8beb67bc0f4)
- initial commit helm chart and configurable ports (b5e568f0a8500ac967328607a8c25614eb8f98ae)
- general overhaul deployments and chart (101ac5720ff06149d5f67a835dfd77881ea7e0fc)
- name indicator (f9c3789415fea27e633559356278813b0899c192)
- default nickname (3f60c14a097eeecd091ac93f260d2ce55a7d9a1e)
- seperate user is used for running tor. Fixed encoding for entrypoint.sh (5562616e88a7896391bf9fb2578a04fc4a2d6fe3)
- homedirectory is owned by toruser (825ec10b98508fafdf25d61c592b9a81292a5623)
- creating .tor directory and chown toruser (9f554414b531fda452512214b21b16dadd0b310a)
- going back too root user (266e983ad4238e7bf721591f21b8203fb53834f3)
- Re-Added toruser and added datadir /tor (fb4050fc9f4f1641267c86c5d93b3b381505901e)
- creation of /tor folder (0f1c700ffdb13a9051b8cffba80738abf3f86211)
- removed toruser (32749370b7bbac9bd2b285e8716e8b3644a09ca0)
-  (dfa1d8c50ef20d66d807b8fa1bbbb9025b755313)
- Added support for setting dnsport,dnslistenaddress,myfamily,hiddenservicedir,hiddenserviceport within torrc (1a5de9ee27a28f46fd1297c66d8223613f3dbb18)
- initial commit gitlab.ci (8eca51ff6213b154f6b525e42cdce6e7626bd790)
- initial commit gitlab-ci (9a50bccced7a744c51be7008194bba2e73233c6c)
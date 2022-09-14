To build whole set (implied you have activated cross-arch docker support e.g. https://github.com/multiarch/qemu-user-static):

```
docker buildx bake 
```


To build only specific architectures:

```
docker buildx bake amd64
```

or

``` 
docker buildx bake amd64
```

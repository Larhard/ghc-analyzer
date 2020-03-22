# Alternatives found

## GHC log scrapping (current)

```
./start_dev.sh
```

In other terminal

```
./make_project.sh
```
## GHC Plugin

```
make -C docker
./start_prod.sh

# In docker environment

cd project/DumperPlugin
make
```

Compile with flag `-fplugin DumperPlugin`

## Custom compilation pipeline

Test approach in home/analyzer/Parser.hs

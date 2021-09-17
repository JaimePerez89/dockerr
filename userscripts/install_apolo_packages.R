# cambio el reposiorio al mismo que el apolo
cran <- "https://cran.rstudio.com/" 

r <- getOption("repos")

r["CRAN"] <- cran

options(repos = r)


# paquete disponibles en este repositorio en el momento de generar la imagen
av_pcks <- available.packages()

# info de los paquetes disponibles en apolo
apolo_pcks_version <- read.csv("/scripts/packages_apolo.csv")

#elimino paquetes duplicados por estar en ods libpath disferentes
apolo_pcks_version <- apolo_pcks_version[!duplicated(apolo_pcks_version$packages),]

apolo_packages <- apolo_pcks_version$packages


# paquetes instalados inicialmente
installed <- as.data.frame(installed.packages())
installed_packages <- installed$Package

#paquetes a instalar
pkgs_to_install <- apolo_packages[!(apolo_packages %in% installed_packages & apolo_pcks_version$version %in% installed$Version)]


# dependencias de los paquetes
dependencies <- sapply(pkgs_to_install, function(x) {
  
  deps <-   tools::package_dependencies(x, db = av_pcks)
  
  if(!is.null(deps)) {
  deps[[1]][deps[[1]] %in% apolo_packages]
  }else {
    c("")
  }
  
})
  

names(dependencies) <- pkgs_to_install

#inicio un bucle que parara cuando todos los paquetes hayan sido instalados
while (length(pkgs_to_install) > 0 ) {

  
  for (package in pkgs_to_install) {
    
    
    #si no hay dependencias a instalar lo instalo
    if ((length(dependencies[[package]]) == 0) | 
      (all(dependencies[[package]] %in% installed_packages))) { 
      
      #si la version es igual a la reciente instalo normal
      version_to_install <- apolo_pcks_version$version[apolo_pcks_version$packages == package]
      
      #puede ocurrir que la version más reciente no este disponible para la versión de r utiliza
      #en este caso instalo la version del archivo
      if (!package %in% row.names(av_pcks)) {
      
      last_version <- "not available"
        
      } else{
      
      last_version <- av_pcks[package,2]
      
      }
      
      if (version_to_install == last_version ) {
        
        install.packages(package,dependencies = FALSE)
        
      # si no lo es instalo desde archivo  
      } else {
        
        #la version a instalar tiene como mucho 3 numeros separados por punto, si hay más los quito
        version_to_install2 <- gsub("^([0-9]+\\.)([0-9]+\\.)([0-9]+)(\\.[0-9]+)(.*)","\\1\\2\\3\\5",version_to_install) 
      
        archive <- "http://cran.r-project.org/src/contrib/Archive/"
        url <- paste0(archive,package,"/",package,"_",version_to_install,".tar.gz")
        
        messages <- capture.output(install.packages(url, repos = NULL))
        
        if (any(unlist(lapply(messages, function(x) grepl("404 Not Found",x))))) {
          
          version_to_install2 <- gsub("^([0-9]+\\.)([0-9]+\\.)([0-9]+)(\\.[0-9]+)(.*)","\\1\\2\\3\\5",version_to_install)
          url <- paste0(archive,package,"/",package,"_",version_to_install2,".tar.gz")
          install.packages(url, repos = NULL)
          
        }
        
        
      }
      
    
    }
  }
  
  installed <- as.data.frame(installed.packages())
  installed_packages <- installed$Package
  pkgs_to_install <- apolo_packages[!(apolo_packages %in% installed_packages & apolo_pcks_version$version %in% installed$Version)]
  
}


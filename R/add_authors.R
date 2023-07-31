#' Adiciona o nome do autor ao título da espécie.
#'
#' @param species_name O nome do autor.
#' @return O título da espécie com o nome do autor adicionado.
#' @export
add_authors <- function(species_name){
  
  # Instalar pacote 'taxize'
  if(!require(taxize)) install.packages("taxize")
  library(taxize)
  
  
  # criar variável onde será salvo o resultado da função
  dados_autores <- data.frame(Autores = character(), stringsAsFactors = FALSE)
  
  # FOR que permite a busca de listas com várias espécies.
  for (i in 1:length(species_name)) {
    
    # Busca do nome científico através da função 'gnr_resolve' da biblioteca taxize.
    result <- gnr_resolve(species_name[i])
    
    # Selecionar nome buscado no banco de dados do 'GBIF'
    nome_aceito <- as.character(result[match("GBIF Backbone Taxonomy", result$data_source_title), "matched_name"])
    
    # Adicionar nome científico com nome do autor à variável de saída 'dados_autores'.
    nova_linha <- data.frame(SpeciesAuthors = nome_aceito, stringsAsFactors = FALSE)
    dados_autores <- rbind(dados_autores, nova_linha)
    
    # Exibir mensagem de progresso
    mensagem <- paste("Progresso:", i, "de", length(species_name))
    cat(mensagem, "\r")  # \r move o cursor para o início da linha para substituir a mensagem na próxima iteração
    #flush.console()      # Força a exibição da mensagem atual no console
    
  }
  
  # Mensagem de conclusão da função.
  cat("\nConcluído!\n")
  flush.console()
  
  # outout
  return(dados_autores)
}
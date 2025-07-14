package com.example.autores.service;

import com.example.autores.entity.Autor;
import com.example.autores.repository.AutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.nio.file.*;

import org.springframework.web.multipart.MultipartFile;

@Service
public class AutorService {

  @Autowired
  private AutorRepository repo;

  private final String IMAGE_DIR = "src/main/resources/static/images/";

  public List<Autor> listar() {
    return repo.findAll();
  }

  public Autor crear(String nombre, String biografia, MultipartFile imagen) {
    Autor a = new Autor();
    a.setNombre(nombre);
    a.setBiografia(biografia);

    try {
      if (imagen != null && !imagen.isEmpty()) {
        String fileName = UUID.randomUUID() + "_" + imagen.getOriginalFilename();
        Path path = Paths.get(IMAGE_DIR + fileName);
        Files.createDirectories(path.getParent()); // crea carpeta si no existe
        Files.copy(imagen.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        a.setImagenUrl("/images/" + fileName);
      }
    } catch (Exception e) {
      throw new RuntimeException("Error al subir imagen", e);
    }

    return repo.save(a);
  }

  public void eliminar(Long id) {
    repo.deleteById(id);
  }

  public Autor actualizar(Long id, Autor datos) {
    datos.setId(id);
    return repo.save(datos);
  }
}

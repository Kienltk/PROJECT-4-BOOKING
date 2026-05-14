package com.pro.booking.service.impl;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.model.Document;
import com.pro.booking.entity.request.DocumentRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.DocumentRepository;
import com.pro.booking.core.CRUDService;
import com.pro.booking.service.DocumentService;
import com.pro.booking.utils.AppUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class DocumentServiceImpl extends CRUDService<Document, DocumentDTO, Long, DocumentRepository> implements DocumentService {
    public DocumentServiceImpl(DocumentRepository repository) {
        super(repository, Document.class, DocumentDTO.class);
    }

    @Value("${upload.file.dir:uploads}")
    private String UPLOAD_FILE_DIR;

    @Override
    public DocumentDTO create(DocumentRequest request, MultipartFile file) throws IOException {
        Files.createDirectories(Paths.get(UPLOAD_FILE_DIR));
        String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        Path path = Paths.get(UPLOAD_FILE_DIR, filename);
        Files.write(path, file.getBytes());
        Document document = super.create(Document.builder()
                .imageUrl(path.toString())
                .type(detectFileType(file))
                .info(file.getOriginalFilename())
                .isPrimary(request.getIsPrimary())
                .build());
        document = super.create(document);
        return mapper.toDto(document);
    }

    @SuppressWarnings("ResultOfMethodCallIgnored")
    @Override
    public DocumentDTO update(DocumentRequest request, MultipartFile file) throws IOException {
        Document oldDoc = super.get(request.getId());
        if(!AppUtils.isNullOrEmpty(file)){
            File oldFile = new File(oldDoc.getImageUrl());
            if (oldFile.exists() && oldFile.isFile()) oldFile.delete();
            Files.createDirectories(Paths.get(UPLOAD_FILE_DIR));
            String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path path = Paths.get(UPLOAD_FILE_DIR, filename);
            Files.write(path, file.getBytes());
            oldDoc.setImageUrl(path.toString());
            oldDoc.setType(detectFileType(file));
            oldDoc.setInfo(file.getOriginalFilename());
        }
        oldDoc.setIsPrimary(request.getIsPrimary());
        oldDoc = super.update(oldDoc);
        return mapper.toDto(oldDoc);
    }


    @Override
    public void deleteFile(DocumentDTO document) {
        File file = new File(document.getImageUrl());
        if (file.exists() && file.isFile()) {
            if (!file.delete()) {
                throw new AppException(ErrorResponse.DELETE_FILE_ERROR);
            }
        }
        super.delete(document.getId());
    }

    @Override
    public List<DocumentDTO> findAllByIdIn(List<Long> ids) throws AppException {
        List<Document> documents = repository.findAllById(ids);
        return mapper.toDtoList(documents);
    }

    private String detectFileType(MultipartFile file) {
        String contentType = file.getContentType();
        if (contentType == null) return "unknown";
        if (contentType.startsWith("image/")) return "image";
        if (contentType.equals("application/pdf")) return "pdf";
        if (contentType.startsWith("video/")) return "video";
        if (contentType.startsWith("audio/")) return "audio";
        if (contentType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
                || contentType.equals("application/msword")) return "doc";
        return "other";
    }
}

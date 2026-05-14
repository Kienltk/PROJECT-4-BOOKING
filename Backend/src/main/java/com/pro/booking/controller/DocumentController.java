package com.pro.booking.controller;

import com.pro.booking.constants.SuccessResponse;
import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.model.Document;
import com.pro.booking.entity.request.DocumentRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.middleware.permission.Permissions;
import com.pro.booking.repository.DocumentRepository;
import com.pro.booking.service.impl.DocumentServiceImpl;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(value = "/api/document")
public class DocumentController extends CRUDInterface<Document, Long, DocumentDTO, DocumentRepository, DocumentServiceImpl> {
    protected DocumentController(DocumentServiceImpl service) {
        super(service, Document.class, DocumentDTO.class);
    }

    @PostMapping
    @Permissions(role = 1L)
    public Object saveFile(@ModelAttribute DocumentRequest request) throws AppException, IOException {
        DocumentDTO document = service.create(request, request.getFile());
        return sendSuccess(document);
    }

    @PostMapping("/multiUpload")
    @Permissions(role = 1L)
    public Object multiUpload(@ModelAttribute DocumentRequest request) throws AppException, IOException {
        List<DocumentDTO> documents = new ArrayList<>();
        for (MultipartFile file : request.getFiles()) {
            DocumentDTO doc = service.create(request, file);
            documents.add(doc);
        }
        return sendSuccess(documents);
    }

    @PutMapping
    @Permissions(role = 1L)
    public Object update(@ModelAttribute DocumentRequest request) throws AppException, IOException {
        MultipartFile file = request.getFile();
        DocumentDTO document = service.update(request, file);
        return sendSuccess(document);
    }

    @DeleteMapping
    @Permissions(role = 1L)
    public Object deleteFile(@RequestBody BaseRequestDTO<DocumentDTO> requestDTO) throws AppException {
        try {
            DocumentDTO documentDTO = requestDTO.getPayload();
            service.deleteFile(documentDTO);
            return sendSuccess(SuccessResponse.DELETE_FILE_SUCCESS);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

}

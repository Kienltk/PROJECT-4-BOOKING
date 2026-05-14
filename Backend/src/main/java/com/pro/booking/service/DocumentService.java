package com.pro.booking.service;

import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.request.DocumentRequest;
import com.pro.booking.exception.AppException;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface DocumentService {

    public DocumentDTO create(DocumentRequest request, MultipartFile file) throws IOException;

    public DocumentDTO update(DocumentRequest request, MultipartFile file) throws IOException;

    public List<DocumentDTO> findAllByIdIn(List<Long> ids) throws AppException;

    public void deleteFile(DocumentDTO document);
}

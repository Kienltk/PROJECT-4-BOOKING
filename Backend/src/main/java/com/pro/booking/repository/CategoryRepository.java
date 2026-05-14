package com.pro.booking.repository;

import com.pro.booking.entity.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long>{
    List<Category> findByType(String type);
}

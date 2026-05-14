package com.pro.booking.repository;

import com.pro.booking.entity.model.Room;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {

    @Query("SELECT r FROM Room r JOIN r.categories c WHERE (:categoryId IS NULL OR c.id = :categoryId)")
    Page<Room> findByCategory(@Param("categoryId") Long categoryId, Pageable pageable);

    @Query("""
                SELECT r FROM Room r
                JOIN r.categories c
                WHERE (:categoryId IS NULL OR c.id = :categoryId)
                AND (:keyword IS NULL OR LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%')) 
                     OR LOWER(c.type) LIKE LOWER(CONCAT('%', :keyword, '%')))
            """)
    Page<Room> findByCategoryAndKeyword(
            @Param("categoryId") Long categoryId,
            @Param("keyword") String keyword,
            Pageable pageable);


    @Query("""
                SELECT r FROM Room r
                JOIN r.categories c
                WHERE (:name IS NULL OR LOWER(c.name) LIKE LOWER(CONCAT('%', :name, '%')))
                   OR (:type IS NULL OR LOWER(c.type) LIKE LOWER(CONCAT('%', :type, '%')))
            """)
    Page<Room> findByCategoryNameOrType(
            @Param("name") String name,
            @Param("type") String type,
            Pageable pageable);


    @Query("""
                SELECT DISTINCT r FROM Room r
                LEFT JOIN r.categories c
                LEFT JOIN r.documents d
                LEFT JOIN r.host h
                WHERE
                    (:categoryId IS NULL OR c.id = :categoryId)
                    AND (
                        :keyword IS NULL OR
                        LOWER(r.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
                        r.subTitle LIKE CONCAT('%', :keyword, '%') OR
                        r.description LIKE CONCAT('%', :keyword, '%') OR
                        LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
                        LOWER(c.type) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
                        LOWER(h.username) LIKE LOWER(CONCAT('%', :keyword, '%')) OR
                        STR(r.pricePerNight) LIKE CONCAT('%', :keyword, '%') OR
                        STR(r.maxGuests) LIKE CONCAT('%', :keyword, '%')
                    )
                    AND (:name IS NULL OR LOWER(c.name) LIKE LOWER(CONCAT('%', :name, '%')))
                    AND (:type IS NULL OR LOWER(c.type) LIKE LOWER(CONCAT('%', :type, '%')))
            """)
    Page<Room> searchRooms(
            @Param("categoryId") Long categoryId,
            @Param("name") String name,
            @Param("type") String type,
            @Param("keyword") String keyword,
            Pageable pageable
    );

}

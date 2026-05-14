package com.pro.booking.config;

import com.pro.booking.service.impl.LocationSyncServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
@Slf4j
public class LocationSyncConfig {

   private final LocationSyncServiceImpl locationSyncService;

   @EventListener(ApplicationReadyEvent.class)
   public void onApplicationReady() {
       try {
           log.info("Syncing...");
           locationSyncService.sync();
           log.info("Sync completed successfully.");
       } catch (Exception e) {
           log.error("Sync failed: {}", e.getMessage(), e);
       }
   }
}

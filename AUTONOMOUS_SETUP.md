# Autonomous Setup: LSC/Tuya Event Archival to Cloud

## Goal
Create near-continuous archival of all available events from LSC/Tuya devices into your own cloud.

## Architecture
1. Device sends event metadata/media to vendor cloud.
2. Collector (Home Assistant or custom service) polls/subscribes to new events.
3. Uploader pushes assets to Google Cloud Storage (or S3-compatible target).
4. Watchdog validates upload freshness and alerts on failure.

## Minimum components
- Always-on host (Raspberry Pi, mini PC, NAS, or VM)
- Docker + Docker Compose
- Home Assistant (or custom collector service)
- rclone or cloud SDK

## Reliability controls
- Local disk queue for pending uploads
- Retry with exponential backoff
- Idempotent object naming
- Heartbeat monitor (`no-upload > 10 min` alerts)
- Daily integrity scan (compare local queue vs bucket)

## Security controls
- Separate service account with least privilege
- Encrypted secrets storage
- TLS-only outbound traffic

## Known limits
- Many LSC/Tuya devices only expose event clips, not true 24/7 raw stream.
- Continuous recording requires hardware that supports RTSP/ONVIF/NVR ingest.

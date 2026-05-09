# LSC Cloud Recorder Replacement Plan

This repository now contains a legal replacement approach instead of modifying a proprietary APK.

## What this provides

- A clean Android app scaffold plan to consume device events via official cloud APIs.
- A backend uploader service plan that stores media/events in your cloud bucket.
- A reliability checklist for always-on uploads with retries and offline queueing.

## Why not patch APK directly

Patching/reverse engineering a proprietary APK can violate terms and can break account/device security.

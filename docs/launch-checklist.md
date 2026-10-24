# thankot.com launch checklist
1. Register/verify thankot.com domain.
2. Create Supabase project.
3. Run supabase/schema.sql in SQL Editor.
4. Create Storage buckets: avatars, post-media, live-recordings.
5. Configure Auth email/social providers and redirect URL.
6. Add Supabase env values to hosting.
7. Add server-side upload validation: MIME, max bytes, 15-second video duration, malware scanning, image dimensions.
8. Create LiveKit project and keep API secret server-side only.
9. Add server endpoint that creates LiveKit access tokens for authenticated users.
10. Deploy Next.js app.
11. Point thankot.com DNS to hosting.
12. Add privacy policy, terms, community guidelines, report/block flow, moderation dashboard, account deletion, age policy.
13. Load-test uploads and live rooms before public launch.

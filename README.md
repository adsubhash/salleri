# thankot.com
A community-first social platform MVP.

## Run immediately
```bash
npm install
npm run dev
```
Open http://localhost:3000

The current MVP works locally without a database: posting, image/video preview, likes, and browser camera preview use local browser state. For a real public platform, connect Supabase using `supabase/schema.sql` and add LiveKit server-side token generation for multi-user live streaming.

## Production stack
- Next.js App Router + React
- Supabase Auth + Postgres + Storage + Realtime
- LiveKit WebRTC for live video
- Vercel/another Node host for deployment

## Media rules
The product target is 15-second short video. Enforce duration server-side during upload in production; client-side checks alone are not security.

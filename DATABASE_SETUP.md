# Database Setup Guide

This guide will help you connect your app to a real PostgreSQL database.

## Quick Start Options

### Option 1: Supabase (Recommended - Free & Easy)

**Best for:** Production, quick setup, free tier available

1. **Sign up at [Supabase](https://supabase.com)**
   - Create a free account
   - Click "New Project"

2. **Create a new project:**
   - Organization: Choose or create one
   - Project Name: `starter` (or your preference)
   - Database Password: Create a strong password (save this!)
   - Region: Choose closest to you
   - Click "Create new project" (takes ~2 minutes)

3. **Get your connection string:**
   - Go to Project Settings (gear icon) → Database
   - Scroll to "Connection string"
   - Select "URI" mode
   - Copy the connection string
   - Replace `[YOUR-PASSWORD]` with your database password

4. **Update your `.env` file:**
   ```env
   DATABASE_URL="postgresql://postgres.xxxx:[YOUR-PASSWORD]@aws-0-us-east-1.pooler.supabase.com:6543/postgres?pgbouncer=true&connection_limit=1"
   ```

5. **Generate Prisma client and push schema:**
   ```bash
   pnpm db:generate
   pnpm db:push
   ```

6. **Verify connection:**
   ```bash
   pnpm db:studio
   ```
   This opens Prisma Studio where you can view your database.

**Benefits:**
- ✅ Free tier: 500MB database, 2GB bandwidth
- ✅ Automatic backups
- ✅ Built-in authentication (optional)
- ✅ Real-time subscriptions
- ✅ Storage for files
- ✅ Edge functions

---

### Option 2: Vercel Postgres

**Best for:** If you're deploying on Vercel

1. **Go to [Vercel Dashboard](https://vercel.com/dashboard)**
2. **Create a new Postgres database:**
   - Storage tab → Create Database
   - Select Postgres
   - Choose a name and region
   - Click "Create"

3. **Get connection string:**
   - Go to your database
   - Copy the `POSTGRES_PRISMA_URL` value

4. **Update `.env`:**
   ```env
   DATABASE_URL="your-vercel-postgres-url"
   ```

5. **Push schema:**
   ```bash
   pnpm db:push
   ```

---

### Option 3: Railway (Free Tier)

**Best for:** Simple deployment, free tier

1. **Sign up at [Railway.app](https://railway.app)**
2. **Create new project → Add PostgreSQL**
3. **Get connection string:**
   - Click on Postgres service
   - Go to "Connect" tab
   - Copy "Prisma" connection string

4. **Update `.env` and push:**
   ```bash
   pnpm db:push
   ```

---

### Option 4: Local PostgreSQL

**Best for:** Development only

#### macOS:
```bash
# Install PostgreSQL
brew install postgresql@16
brew services start postgresql@16

# Create database
createdb starter

# Update .env
DATABASE_URL="postgresql://$(whoami)@localhost:5432/starter?schema=public"

# Push schema
pnpm db:push
```

#### Windows:
1. Download from [PostgreSQL.org](https://www.postgresql.org/download/windows/)
2. Install with default settings
3. Create database using pgAdmin
4. Update `.env` with connection string

#### Linux:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql

# Create database
sudo -u postgres createdb starter

# Update .env
DATABASE_URL="postgresql://postgres@localhost:5432/starter?schema=public"

# Push schema
pnpm db:push
```

---

## After Connecting Your Database

### 1. Generate Prisma Client
```bash
pnpm db:generate
```

### 2. Push your schema (for development)
```bash
pnpm db:push
```

**Or** create a migration (for production):
```bash
pnpm db:migrate
```

### 3. Open Prisma Studio to view your data
```bash
pnpm db:studio
```

### 4. Seed your database (optional)

Create `prisma/seed.ts`:
```typescript
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  // Create example user
  const user = await prisma.user.create({
    data: {
      email: 'test@example.com',
      name: 'Test User',
    },
  })

  console.log({ user })
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
```

Add to `package.json`:
```json
"prisma": {
  "seed": "tsx prisma/seed.ts"
}
```

Install tsx and run:
```bash
pnpm add -D tsx
pnpm prisma db seed
```

---

## Environment Variables for Production

When deploying, add these environment variables to your hosting platform:

### Vercel:
- Project Settings → Environment Variables
- Add `DATABASE_URL`

### Netlify:
- Site Settings → Environment Variables
- Add `DATABASE_URL`

### Railway:
- Service Variables
- Add `DATABASE_URL`

---

## Troubleshooting

### Connection Issues

**Error: P1001 - Can't reach database server**
- Check your connection string format
- Verify database is running
- Check firewall settings

**Error: P1003 - Database does not exist**
- Create the database first
- For Supabase, use the default `postgres` database name

**Error: SSL required**
- Add `?sslmode=require` to connection string
- Or use Supabase's recommended connection string

### SSL Configuration

For production databases, you may need SSL:
```env
DATABASE_URL="postgresql://user:pass@host:5432/db?sslmode=require"
```

---

## Best Practices

1. **Never commit `.env`** - It's in `.gitignore` already
2. **Use `.env.local`** for local overrides (also in `.gitignore`)
3. **Use connection pooling** for serverless (PgBouncer with Supabase)
4. **Run migrations** in production, not `db:push`
5. **Backup regularly** (Supabase does this automatically)

---

## Need Help?

- [Prisma Documentation](https://www.prisma.io/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

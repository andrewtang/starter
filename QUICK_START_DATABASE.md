# Quick Start: Connect to a Real Database

## 🚀 Fastest Method: Supabase (5 minutes)

### Step 1: Create Supabase Account
Go to **https://supabase.com** and sign up (free)

### Step 2: Create a Project
- Click "New Project"
- Name: `starter` (or anything you like)
- Database Password: Create one (you'll need this!)
- Region: Choose closest to you
- Click "Create new project" (wait ~2 minutes)

### Step 3: Get Connection String
1. Click the **gear icon** (Project Settings)
2. Click **Database** in left sidebar
3. Scroll to **Connection string**
4. Select **URI** tab
5. Copy the connection string
6. Replace `[YOUR-PASSWORD]` with the password you created

### Step 4: Update Your App
```bash
# Open your .env file and replace the DATABASE_URL line with:
DATABASE_URL="your-copied-connection-string-here"

# Then run:
pnpm db:generate
pnpm db:push
```

### Step 5: Verify It Works
```bash
pnpm db:studio
```

This opens a UI where you can see your database! 🎉

---

## 📝 Or Use the Interactive Script

```bash
pnpm db:setup
```

Choose option 1 (Supabase) and follow the prompts.

---

## ✅ What You Get with Supabase Free Tier

- 500MB database storage
- 2GB bandwidth
- Unlimited API requests
- Automatic backups
- Real-time subscriptions
- Built-in authentication
- File storage
- No credit card required!

---

## 🔧 Useful Commands

```bash
# View your database in a UI
pnpm db:studio

# Push schema changes to database
pnpm db:push

# Create a migration (for production)
pnpm db:migrate

# Generate Prisma Client after schema changes
pnpm db:generate
```

---

## 🆘 Common Issues

**"Can't reach database server"**
- Check your connection string is correct
- Make sure you replaced `[YOUR-PASSWORD]` with your actual password

**"Database does not exist"**
- Use the default database name from Supabase (usually `postgres`)

**"SSL required"**
- Supabase requires SSL by default - their connection string includes this

---

## 📚 Need More Options?

See **[DATABASE_SETUP.md](./DATABASE_SETUP.md)** for:
- Vercel Postgres
- Railway
- Local PostgreSQL
- Troubleshooting
- Production tips

#!/bin/bash

echo "🗄️  Database Setup Script"
echo "======================="
echo ""
echo "This script will help you set up your database connection."
echo ""
echo "Choose your database provider:"
echo "1) Supabase (Recommended - Free)"
echo "2) Vercel Postgres"
echo "3) Railway"
echo "4) Local PostgreSQL"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
  1)
    echo ""
    echo "📋 Supabase Setup"
    echo "================="
    echo "1. Go to https://supabase.com and sign up"
    echo "2. Create a new project"
    echo "3. Get your connection string from Project Settings → Database"
    echo ""
    read -p "Paste your Supabase connection string: " db_url
    ;;
  2)
    echo ""
    echo "📋 Vercel Postgres Setup"
    echo "======================="
    echo "1. Go to https://vercel.com/dashboard"
    echo "2. Storage → Create Database → Postgres"
    echo "3. Copy the POSTGRES_PRISMA_URL"
    echo ""
    read -p "Paste your Vercel Postgres URL: " db_url
    ;;
  3)
    echo ""
    echo "📋 Railway Setup"
    echo "==============="
    echo "1. Go to https://railway.app and sign up"
    echo "2. New Project → Add PostgreSQL"
    echo "3. Copy the Prisma connection string"
    echo ""
    read -p "Paste your Railway connection string: " db_url
    ;;
  4)
    echo ""
    echo "📋 Local PostgreSQL Setup"
    echo "========================"
    echo ""
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Detected macOS"
      echo "Installing PostgreSQL with Homebrew..."
      if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found. Please install it from https://brew.sh"
        exit 1
      fi
      brew install postgresql@16
      brew services start postgresql@16
      echo "✅ PostgreSQL installed and started"
    fi

    echo ""
    read -p "Database name (default: starter): " db_name
    db_name=${db_name:-starter}

    echo "Creating database..."
    createdb $db_name 2>/dev/null || echo "Database may already exist"

    db_url="postgresql://$(whoami)@localhost:5432/$db_name?schema=public"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

echo ""
echo "Updating .env file..."
if [ -f .env ]; then
  # Backup existing .env
  cp .env .env.backup
  echo "✅ Backed up existing .env to .env.backup"
fi

# Update or create .env
if grep -q "DATABASE_URL=" .env 2>/dev/null; then
  # Replace existing DATABASE_URL
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|DATABASE_URL=.*|DATABASE_URL=\"$db_url\"|" .env
  else
    sed -i "s|DATABASE_URL=.*|DATABASE_URL=\"$db_url\"|" .env
  fi
else
  # Add DATABASE_URL
  echo "DATABASE_URL=\"$db_url\"" >> .env
fi

echo "✅ Updated .env file"
echo ""
echo "🔄 Generating Prisma Client..."
pnpm db:generate

echo ""
echo "📤 Pushing database schema..."
pnpm db:push

echo ""
echo "✅ Database setup complete!"
echo ""
echo "🎉 You can now:"
echo "   - Run 'pnpm db:studio' to view your database"
echo "   - Run 'pnpm dev' to start your app"
echo ""

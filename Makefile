run:
	ws 8080 .

copy_index:
	cp index.html api/index.html
	cd api && sed -i '' 's#<title>Snowflake Documentation</title>#<title>Snowflake Documentation | Developer API</title>#' index.html
	cd api && sed -i '' 's#<link rel="canonical" href="http://documentation.snowflake.ai/" />#<link rel="canonical" href="http://documentation.snowflake.ai/api/" />#' index.html
	cp index.html features/index.html
	cd features && sed -i '' 's#<title>Snowflake Documentation</title>#<title>Snowflake Documentation | Features</title>#' index.html
	cd features && sed -i '' 's#<link rel="canonical" href="http://documentation.snowflake.ai/" />#<link rel="canonical" href="http://documentation.snowflake.ai/features/" />#' index.html
	cp index.html getting-started/index.html
	cd getting-started && sed -i '' 's#<title>Snowflake Documentation</title>#<title>Snowflake Documentation | Getting Started</title>#' index.html
	cd getting-started && sed -i '' 's#<link rel="canonical" href="http://documentation.snowflake.ai/" />#<link rel="canonical" href="http://documentation.snowflake.ai/getting-started/" />#' index.html

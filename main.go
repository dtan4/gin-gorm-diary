package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

type Article struct {
	gorm.Model
	Title  string `json:"title"`
	Author string `json:"author"`
	Body   string `json:"body"`
}

func main() {
	db, err := gorm.Open("postgres", "user=postgres password=password host=localhost port=5432 dbname=gin_gorm_diary sslmode=disable")
	if err != nil {
		log.Fatal("Failed to connect database!")
	}

	db.AutoMigrate(&Article{})

	r := gin.Default()

	r.GET("/articles", func(c *gin.Context) {
		var articles []Article

		db.Select("title, author, body").Find(&articles)

		c.JSON(http.StatusOK, articles)
	})

	r.Run()
}

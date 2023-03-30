
## YelpSearch



### Here is a high-level overview of each step 

## Architecture Used : VIPER
    
##### Presenter: Processes events from the View and the Interactor, preparing the data for display, and updating the View.

###### Entity: Represents the Date object used throughout the application.

##### Router: Manages navigation between screens.




## API Reference

#### Get RestaurantList

```http
  GET /api.yepl.com/v3/business/search
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `laitude` | `string` |  "37.2222"
  `Logititude` | `string` | *-102.77*

#### Get Restaurant Detail

```http
  GET /api.yepl.com/v3/business/{Id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **RestaurantId**. Id of item to fetch |



## Demo

Insert gif or link to demo

Demo link : **https://user-images.githubusercontent.com/16301500/228790520-58e4e161-102a-49fb-af34-e7ec026203d1.mp4**



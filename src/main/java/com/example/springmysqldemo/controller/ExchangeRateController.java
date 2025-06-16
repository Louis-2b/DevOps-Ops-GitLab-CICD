package com.example.springmysqldemo.controller;

import com.example.springmysqldemo.model.ExchangeRate;
import com.example.springmysqldemo.service.ExchangeRateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
public class ExchangeRateController {
    @Autowired
    ExchangeRateService exchangeRateService;

    @GetMapping("/getAmount")
    public double getAmount(@RequestParam String sourceCurrency, @RequestParam String targetCurrency) {
        return exchangeRateService.getAmount(sourceCurrency, targetCurrency);
    }

    @PostMapping("/addExchangeRate")
    public ExchangeRate addExchangeRate(@RequestBody ExchangeRate exchangeRate) {
        return exchangeRateService.addExchangeRate(exchangeRate);
    }
}

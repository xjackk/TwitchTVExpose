#  tkillilea my utility functions being added to $ namespace (jQuery)
define ["jquery", "mockjax", "mockjson" ], ($)->

    $.mockJSON.data.CCY = ['USD', 'USD', 'USD', 'USD','USD', 'USD', 'USD', 'USD', 'USD', 'USD', 'USD', 'USD','USD', 'USD', 'USD', 'USD', 'USD', 'USD', 'USD','EUR']
    $.mockJSON.data.PERIOD = ['1M', '2M', '3M', '4M','5M','6M','7M','8M', '9M', '10M', '11M', '12M']
    $.mockJSON.data.PORTFOLIO = ['CI_SF_STF', 'CI_SF_SFLN', 'CI_SF_PF']
    $.mockJSON.data.LPTYPE = ['EM', 'BF', 'IF','RF','BF','BF','BF','EM','EM','BF']
    $.mockjaxClear()

    #liquidity spread currencies
    $.mockjax
        url: "/zd-api/LSCurrency"
        responseTime: 333
        dataType: "json"
        proxy: "mocks/lscurrency.json"

#loan processing
# {"id":4,"UserName":"xn09484","Savedate":"2013-06-04T00:00:00","TimeStampUTC":"2013-06-04T20:40:54.5624215+00:00","TradeID":16674670,"CCY":"USD",
# "Portfolio":"CI_SF_STF","Counterparty":null,"ScheduleIndex":"USD LIBOR    1W","LPType":"EM","SAPCML":"9702009651_9702014605","LS":0.599,"LPR":0.40508833920587162,
# "ChangeOutstanding":-426562.5,"PVLossBenefit":-2014.0843025239135,"NewEndDate":"2013-06-05T00:00:00","OldEndDate":"2015-10-27T00:00:00","FlowCount":126}
# post with a 5 second delay for UI testing...
    $.mockjax
        url: "/zd-api/lp"
        type: "POST"
        responseTime: 500
        dataType: "json"
        responseText: $.mockJSON.generateFromTemplate
            "id|100-500": 0
            "UserName": "@MALE_FIRST_NAME"
            "SaveDate": new Date()
            "TimeStampUTC": new Date()
            "TradeID|16000000-16699999": 0
            "CCY": "@CCY"
            "Portfolio": "@PORTFOLIO"
            "Counterparty": "@LOREM"
            "ScheduleIndex": "@LOREM"
            "LPType": "@LPTYPE"
            "SAPCML": "@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER@NUMBER"
            "LS": Math.random()
            "LPR": Math.random()
            "ChangeOutstanding|0-100000": 0
            "PVLossBenefit|0-10000": 0
            "NewEndDate":"@DATE_MM/@DATE_DD/@DATE_YYYY"
            "OldEndDate":"@DATE_MM/@DATE_DD/@DATE_YYYY"
            "FlowCount|1-256": 0

#get
    $.mockjax
        url: "/zd-api/lp"
        responseTime: 1000
        dataType: "json"
        proxy: "mocks/lp.json"

    #application state
    $.mockjax
        responseTime: 100
        url: "/zd-api/appstate"
        dataType: "json"
        proxy: "mocks/appstate.json"


    #current logged in user
    $.mockjax
        url: "/zd-api/currentuser"
        dataType: "json"
        responseTime: 100
        responseText: $.mockJSON.generateFromTemplate
            "d":
                "status": "success"
                "data":
                    "loginID": "XN49123"
                    "fullName": "@MALE_FIRST_NAME @LAST_NAME"
                    "department" : "TR"
                    "culture" : "en-US"
                    "email" : "xyz@EMAIL"
                    "timeZone": "Eastern Standard Time"

#{"status":"success","properties":
#{"timestamp":"2013-06-10T10:07:07","curvename":"USDCURVE"},
#"series":[
#{"id":1,"Period":"1M","Date":"2013-07-10T00:00:00","Yield":.01,"discFactor":.9999}
    $.mockjax
        url: "/zd-api/curve/*"
        contentType: "text/json"
        responseTime: 100
        dataType: "json"
        responseText: $.mockJSON.generateFromTemplate
            "status": "success"
            "properties": {"timestamp": new Date(), "curvename": "USDCURVE"}
            "series|12-24": [{
                "id|+1": 0
                "Period" : "@PERIOD"
                "Date": "@DATE_MM/@DATE_DD/@DATE_YYYY"
                "Yield": Math.random()
                "discFactor": Math.random()
                }]


# {"status":"success","data":{"ccy":"USD","timestamp":"2013-06-13","curve1":"TK_Ungedeckt","curve2":"USDLIBOR","rows":[{"id":1,"Period":"1M","TK":.0025,"xCCYBSS":.0025,"bidOffer":.00025,"LS":.00525},
    $.mockjax
        url: "/zd-api/ls/*"
        responseTime: 500
        contentType: "text/json"
        #dataType: "json"
        responseText: $.mockJSON.generateFromTemplate
            "status": "success"
            "data": {"ccy": @CCY, "timestamp": new Date(), "curve1":"TK_Ungedeckt","curve2":"USDLIBOR","rows|12-36":[{
                    "id|+1": 0
                    "Period" : "@PERIOD"
                    "TK": "@DATE_MM/@DATE_DD/@DATE_YYYY"
                    "xCCYBSS": Math.random()
                    "bidOffer": Math.random()
                    "LS": Math.random()
                }]
            }
- (void)addDataInRequest:(NSMutableURLRequest*)urlRequest fromDict:(NSDictionary*)dict andUploadData:(NSData*)data dataType:(PSMediaType)mediaType dataKey:(NSString*)dataKey{
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //Append Request Dict
    NSMutableData *postDataBody = [NSMutableData data];
    [postDataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postDataBody appendData:[@"Content-disposition: form-data; name=\"data\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postDataBody appendData:[ jsonString  dataUsingEncoding:NSUTF8StringEncoding]];
    [postDataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    if (data)
    {
        NSString * timeStampValue = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        NSString *fileName = @"";
        if (mediaType == PSMediaTypeImage)
            fileName = [NSString stringWithFormat:@"Img_%@.jpg",timeStampValue];
        else if (mediaType == PSMediaTypeVideo)
            fileName = [NSString stringWithFormat:@"Vid_%@.mp4",timeStampValue];
        
        // Append image File
        [postDataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //imageData , userImage
        [postDataBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",dataKey, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postDataBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postDataBody appendData:[NSData dataWithData:data]];
        [postDataBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [urlRequest setHTTPBody:postDataBody];
    urlRequest.HTTPMethod = @"POST";
}
